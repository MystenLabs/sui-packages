module 0x2a4fc8e4d093c622a688ee90dead203b40680c9c88c79bbff11f91b9e3dd3901::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCAT>(arg0, 6, b"NCAT", b"NEIRO CAT", b"Neiro Cat is a meme token powered by community creativity. Named after \"neural\" for collective intelligence, it grew thanks to its playful cat mascot and strong, meme-loving community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_00_17_02_4101150c65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

