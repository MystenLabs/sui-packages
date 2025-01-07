module 0xb5fe15a29beb6f7e63242324bc1321e6c728e3921ac889e9448793412330d908::api {
    struct API has drop {
        dummy_field: bool,
    }

    fun init(arg0: API, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<API>(arg0, 6, b"API", b"Autism Penguin Illuminati", b"Autism Penguin Illuminati... Autism Penguin Illuminati...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_211300_32d70bfae4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<API>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<API>>(v1);
    }

    // decompiled from Move bytecode v6
}

