module 0x76ba79bdd305fb1db9e40b4730a84461b436206d7c91b747348569177709baec::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"Apesui", b"Money Ape", b"Little Ape Print Out Money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_02_08_22_6932ea4a_fa6e346f2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

