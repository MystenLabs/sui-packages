module 0x94f6987b3a596e5951a9e903296595335c0fe080c6a1168f70034ff2b76f8dd8::climber {
    struct CLIMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIMBER>(arg0, 6, b"Climber", b"Climber Ape Sui", b"Climber wants to reach the top and become the highest climber of all! For every dollar invested, he climbs one meter higher. Help him conquer new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_b6b15546a8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

