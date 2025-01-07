module 0x5027864fbb92159b02e003423e408a73fbb0cf1b0c406de60e2957ac45dfa22d::deviloni {
    struct DEVILONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVILONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILONI>(arg0, 6, b"DEVILONI", b"The Devil Oni", b"In Japanese folklore, Oni are demons or ogres. They are typically large and scary-looking with red or blue skin, horns, and sharp claws. They are known for their strength and love to cause trouble. Sometimes, they are even said to eat people!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xnjgp_QWYAAR_1q_J_051d0e241b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVILONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

