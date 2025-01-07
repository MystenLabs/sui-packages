module 0x47812ecbc960484b7509ef5f8d6100646002c48831d4414a8f050e5409ffdc68::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 9, b"SUIKI", b"Suikipedia", b"Suikipedia (SUIKI) is a decentralized token built on the Sui blockchain, drawing inspiration from the collaborative nature of Wikipedia. SUIKI allows users to contribute knowledge, fund innovative projects, and support community-driven initiatives. With a focus on privacy and decentralization, Suikipedia creates a secure platform for sharing information and rewarding users for their valuable contributions across various fields.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1742847272369700864/2kVujfip.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

