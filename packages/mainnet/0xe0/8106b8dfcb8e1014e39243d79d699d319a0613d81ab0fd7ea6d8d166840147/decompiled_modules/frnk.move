module 0xe08106b8dfcb8e1014e39243d79d699d319a0613d81ab0fd7ea6d8d166840147::frnk {
    struct FRNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRNK>(arg0, 9, b"FRNK", b"AnneFrank", b"111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebcbe522cccd22bd69444d46c6c7b677blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

