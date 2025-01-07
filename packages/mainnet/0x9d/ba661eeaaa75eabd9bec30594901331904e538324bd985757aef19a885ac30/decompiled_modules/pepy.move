module 0x9dba661eeaaa75eabd9bec30594901331904e538324bd985757aef19a885ac30::pepy {
    struct PEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPY>(arg0, 9, b"PEPY", b"Cool Pepy", b"Cool Pepy is a collection on the Sui blockchain featuring fun, cartoonish frog characters with unique traits. Each token is a one-of-a-kind collectible, offering holders access to exclusive events and community benefits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1802591179378397184/UW3Lm7NX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

