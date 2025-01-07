module 0x715f14446939367b6708d85fbae3a20daef410a8d7d4375bc5194ca5cc3b5cd::cryptid001 {
    struct CRYPTID001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTID001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTID001>(arg0, 6, b"Cryptid001", b"NINGEN", b"Here is an unknown Antarctic creature, designated as 001. It was created in isolation, right in Antarctica.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241010111054_1672ad1e2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTID001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYPTID001>>(v1);
    }

    // decompiled from Move bytecode v6
}

