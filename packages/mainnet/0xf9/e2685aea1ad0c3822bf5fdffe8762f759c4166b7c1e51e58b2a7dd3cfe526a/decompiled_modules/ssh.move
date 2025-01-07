module 0xf9e2685aea1ad0c3822bf5fdffe8762f759c4166b7c1e51e58b2a7dd3cfe526a::ssh {
    struct SSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSH>(arg0, 6, b"SSH", b"SUI SLEEPING HIPPO", b"Don't wake me up if we not reach 100M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MICKY_12_baeb77aaa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

