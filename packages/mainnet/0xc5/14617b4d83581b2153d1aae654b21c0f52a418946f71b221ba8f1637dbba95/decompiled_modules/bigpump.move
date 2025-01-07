module 0xc514617b4d83581b2153d1aae654b21c0f52a418946f71b221ba8f1637dbba95::bigpump {
    struct BIGPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGPUMP>(arg0, 9, b"BIGPUMP", b"Big Pump", b"BIGPUMP is a meme coin that represents what everyone in crypto is dreaming of: a Big Pump of their coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1776118004675129344/BCJMzo-G_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGPUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGPUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

