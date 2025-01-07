module 0x23038e4cb30f186d7250eb4db6c1d6ee7b2ce58e71af7f887656acbe51e2def3::saa {
    struct SAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAA>(arg0, 6, b"SAA", b"SUI ANIME AI", x"456c6f6e204d75736b204c6f76657320416e696d652c20436f6d62696e656420576974682041490a57652048617665205341410a4c6574277320536861726520536f20456c6f6e204d75736b2043616e204b6e6f77205573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017433_faf7a9b0f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

