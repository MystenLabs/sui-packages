module 0xb26239288d9f1292aa8e639c66e73601ca7cb390c916c95c7540f7bd805dc60f::suitate {
    struct SUITATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATE>(arg0, 9, b"SUITATE", b"Daddy Tate on SUI", b"the first tate coin on this blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/40f90da7d98f538fac8a5785c2480115blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

