module 0x503693222204cf428961f59e12b9243c7e572d21c1ab02a42729b20e3bbe51c3::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS>(arg0, 6, b"OPTIMUS", b"Optimus Prides", b"We are a meme/parody community built around all things in new Generation that we called GEN-Z...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/robot_dd347c5106.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

