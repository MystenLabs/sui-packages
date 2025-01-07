module 0x27866c118aa89a35bd29ff0ac8bf3bd68115d0b1f2f3958e7c997bd4df70efe6::pepezzz {
    struct PEPEZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEZZZ>(arg0, 6, b"PEPEZZZ", b"Gen Z Pepe", x"6a7573742061206c696c2066726f6720616464696374656420746f2074696b746f6b200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Xi0_IG_1_L_400x400_dc89c6d887.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

