module 0x97923cc0e1bd4dc86627635278dab63de458edfaed22bf0bd731769612476b93::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"NEIRO", b"Neiro On SUI", b"Neiro on Sui ($NEIRO) Neiro launching on the Sui blockchain as Doge's successor. $NEIRO is ready to take over SUI, led by a team with experience in multi-million dollar projects. Join the movement and be part of the future of meme coins with $NEIRO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_9692_c758afa043.PNG&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x9bb6db5487f1e5b2c96d95d8212fde17560e1940b936de251f9bf0a9fd68e99c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

