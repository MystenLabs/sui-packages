module 0x525759732a5586868a43d8c90712e787abaf3ff2e075ef9c19cfb5d174222f75::mindboggli {
    struct MINDBOGGLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDBOGGLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINDBOGGLI>(arg0, 8, b"MINDBOGGLI", b"mindbogglingly", b"MINDBOGGLI on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/82b45b6b-f509-41bf-9049-4484087f3596.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINDBOGGLI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDBOGGLI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINDBOGGLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

