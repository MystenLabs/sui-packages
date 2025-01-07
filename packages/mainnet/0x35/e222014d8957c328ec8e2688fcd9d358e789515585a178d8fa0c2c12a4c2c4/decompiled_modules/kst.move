module 0x35e222014d8957c328ec8e2688fcd9d358e789515585a178d8fa0c2c12a4c2c4::kst {
    struct KST has drop {
        dummy_field: bool,
    }

    fun init(arg0: KST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KST>(arg0, 6, b"KST", b"Koki Sui Token", b"My name is Koki, I'm a girl;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_03_D_06_11_06_6860ad1530.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KST>>(v1);
    }

    // decompiled from Move bytecode v6
}

