module 0xb250160eb2e875fa6dcee27f3495c839554723ebb5f14120db50a6f35fb8e730::urs {
    struct URS has drop {
        dummy_field: bool,
    }

    fun init(arg0: URS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URS>(arg0, 9, b"URS", b"Uranus", b"UranusCoin is the newest intergalactic memecoin that's ready to shake up the crypto universe. Inspired by the playful energy of the planet Uranus, this token blends fun with serious potential, bringing a mix of meme culture and community power to the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/-LrvPLT2O8PoP3bh?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<URS>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URS>>(v1);
    }

    // decompiled from Move bytecode v6
}

