module 0xdee690e668b05149c2969365b937a32132f60de7dc9d59457aaf11d08a16ef91::bwh {
    struct BWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWH>(arg0, 6, b"BWH", b"Biden Wif Hat", b"Maga hat token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241005_140410_Chrome_0a43b21f26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

