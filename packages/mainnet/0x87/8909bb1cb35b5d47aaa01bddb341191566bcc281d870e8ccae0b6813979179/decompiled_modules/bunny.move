module 0x878909bb1cb35b5d47aaa01bddb341191566bcc281d870e8ccae0b6813979179::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Honey Bunny", b"HoneyBunny is a fun, cute meme token offering sweet rewards and adorable NFTs, perfect for holders who enjoy a playful and lighthearted crypto experience!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1145733208618631168/2N8z-1kk.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUNNY>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

