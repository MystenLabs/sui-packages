module 0x1703c4cd8e4e8b5b9dbe3bfe79cd01f809abf172710978346bd54dbaa6eb6202::csm {
    struct CSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSM>(arg0, 6, b"CSM", b"Cat sui meme", b"The new Meme that will reach the skys and above ... Let's get it to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000401288_e5eac90415.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

