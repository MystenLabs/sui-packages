module 0xc173df7f3361c8764e1eb13eb0f99a4e37de44bd6150ff990d24e9b9c3dd7be2::vinu {
    struct VINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINU>(arg0, 9, b"VINU", b"VITA INU", b"VINU Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1687146463938191371/lUo4MEnI_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

