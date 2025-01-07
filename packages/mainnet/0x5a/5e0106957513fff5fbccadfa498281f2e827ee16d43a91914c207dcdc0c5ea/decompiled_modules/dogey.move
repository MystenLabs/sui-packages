module 0x5a5e0106957513fff5fbccadfa498281f2e827ee16d43a91914c207dcdc0c5ea::dogey {
    struct DOGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEY>(arg0, 6, b"DOGEY", b"DOGEY SUI", x"24444f474559207374616e647320666f7220446f204f6e6c7920476f6f642045766572796461592c2061206d697373696f6e20746f20647269766520706f736974697665206368616e676520696e2063727970746f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Uck_Mp_Vp_400x400_232b3a609b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

