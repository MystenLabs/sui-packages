module 0x64651f1e6f4c87d5499f78e950c59ba8aa02611ba2b3e2e3ca2534bed536283c::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"Cetus", b"CETUS", x"546865206c656164696e672044455820616e64206c69717569646974792070726f746f636f6c206f6e20235375692e200a546865206b6579206c697175696469747920616e64207377617020696e667261206f6620235375692e200a2343657475732c207768657265205375692074726164696e672068617070656e732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_ae_a_ae_ae_a_17308723743881_d73fc7626d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

