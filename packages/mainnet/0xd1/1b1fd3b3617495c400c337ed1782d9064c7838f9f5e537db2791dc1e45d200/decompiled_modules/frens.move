module 0xd11b1fd3b3617495c400c337ed1782d9064c7838f9f5e537db2791dc1e45d200::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 9, b"FRENS", b"suifrens", b"SUIFRENS KIOSKS holder will get frens for energy solary investemnt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eb80098d756548bad6fb8b02fc327f5fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

