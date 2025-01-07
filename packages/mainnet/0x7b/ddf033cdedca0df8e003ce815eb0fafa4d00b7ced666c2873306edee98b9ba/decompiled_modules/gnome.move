module 0x7bddf033cdedca0df8e003ce815eb0fafa4d00b7ced666c2873306edee98b9ba::gnome {
    struct GNOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNOME>(arg0, 6, b"GNOME", b"USA GNOME", b"ASSEMBLE GNOMES! TODAY WE STORM THE US OF A AND GET RID OF THOSE PESKY KNIGHTS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_222208_801_66d61fdd19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

