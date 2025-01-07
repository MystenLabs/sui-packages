module 0xc15f65951c81e1e1083c14c801f7367028edd633e4383a5205bd5190631bba2c::suiriken {
    struct SUIRIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIKEN>(arg0, 6, b"SUIRIKEN", b"SUIRIKEN - Shuriken of Sui", b"The SUIRIKEN is a specialized shuriken that draws its power from the principles of SUi, representing fluidity, precision, and adaptability. Forged with lightweight, reflective metal, the SUIRIKEN has sharp, curved blades designed to mimic the flowing movements of water. When thrown, it glides with extraordinary speed and accuracy, capable of changing its trajectory mid-flight, making it nearly impossible to predict or evade. Its design incorporates the symbol of SUi, embodying balance and harmony, and is often used by elite warriors trained in the art of seamless, fluid combat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiriken_c0c6563150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

