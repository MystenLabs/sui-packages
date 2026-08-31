module 0xaa15ceada70521dd0d8b8c0b1cecc5d4f6670463f8cb1f889be99d7316328abf::look {
    struct LOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/460px-Iconic-Memes-Step-4-LAORpQvPgs6MQlMUGHDOcS2mUn66EK.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/460px-Iconic-Memes-Step-4-LAORpQvPgs6MQlMUGHDOcS2mUn66EK.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<LOOK>(arg0, 9, b"LOOK", b"look", b"test", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOK>>(0x2::coin::mint<LOOK>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOK>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

