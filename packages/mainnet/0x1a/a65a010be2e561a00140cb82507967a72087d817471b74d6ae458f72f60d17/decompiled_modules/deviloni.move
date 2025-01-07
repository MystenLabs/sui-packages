module 0x1aa65a010be2e561a00140cb82507967a72087d817471b74d6ae458f72f60d17::deviloni {
    struct DEVILONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVILONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILONI>(arg0, 6, b"DEVILONI", b"DEVIL ONI", b"In Japanese folklore, Oni are demons or ogres. They are typically large and scary-looking with red or blue skin, horns, and sharp claws. They are known for their strength and love to cause trouble. Sometimes, they are even said to eat people!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DINOSUI_5_761490d1cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVILONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

