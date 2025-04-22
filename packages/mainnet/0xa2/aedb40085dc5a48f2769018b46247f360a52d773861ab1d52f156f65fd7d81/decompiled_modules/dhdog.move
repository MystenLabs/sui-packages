module 0xa2aedb40085dc5a48f2769018b46247f360a52d773861ab1d52f156f65fd7d81::dhdog {
    struct DHDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHDOG>(arg0, 6, b"DHDOG", b"Dh-Dog", b"Sorry for the misunderstanding. DH-DOG is the most retro dog in the gaming industry. Check out the website play duck hunt screenshot your high score for a chance at 1m tokens supply at the end of the week. Post you high score in the tg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061103_02322fdc28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

