module 0xcac6905c303db6d02b629664588ae07625297e9b289c31752dad8886d92bc1fe::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"HORNY", b"Horny the goat", b"The horniest GOAT in all of crypto, Horny plans to climb the tallest peaks. More than just an animal, GOAT represents an acronym for the greatest of all time, something we aim to place our community status into. Goats are known to be able to climb the steepest of mountains, something our ethos heavily relates to.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054424_d9844bda4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

