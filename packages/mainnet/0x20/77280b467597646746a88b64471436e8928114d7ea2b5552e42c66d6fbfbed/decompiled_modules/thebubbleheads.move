module 0x2077280b467597646746a88b64471436e8928114d7ea2b5552e42c66d6fbfbed::thebubbleheads {
    struct THEBUBBLEHEADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBUBBLEHEADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBUBBLEHEADS>(arg0, 9, b"Bubble", b"The Bubbleheads", b"Website: https://jup.ag/studio/3G1yVFfKzZxsvTnAnJMQzZBtyTpfWUTY6G7685nRjups | Twitter: https://x.com/i/communities/1949444656288387479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-create.jup.ag/images/3G1yVFfKzZxsvTnAnJMQzZBtyTpfWUTY6G7685nRjups")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THEBUBBLEHEADS>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBUBBLEHEADS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEBUBBLEHEADS>>(v1);
    }

    // decompiled from Move bytecode v6
}

