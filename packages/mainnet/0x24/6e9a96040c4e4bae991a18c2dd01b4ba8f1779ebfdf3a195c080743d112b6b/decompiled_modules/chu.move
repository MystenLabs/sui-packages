module 0x246e9a96040c4e4bae991a18c2dd01b4ba8f1779ebfdf3a195c080743d112b6b::chu {
    struct CHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHU>(arg0, 6, b"Chu", b"Churro on Sui", b"Churro on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3d3a144502b0524b7269b9cb94bc3b12_f1178a2a90.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

