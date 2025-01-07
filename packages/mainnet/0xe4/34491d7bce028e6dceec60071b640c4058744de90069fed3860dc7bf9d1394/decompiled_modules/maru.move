module 0xe434491d7bce028e6dceec60071b640c4058744de90069fed3860dc7bf9d1394::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"Maru Shiba Inu", b"Marutaro, the famous Shiba Inu from Japan, is beloved for his cute and expressive face across Instagram and social media. He rose to internet stardom around 2013 thanks to the heartwarming and funny posts shared by his owner, Shinjiro Ono, earning him recognition as one of the OG Shiba memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x7afd0d633e0a2b1db97506d97cadc880c894eca9_80e0cae545.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

