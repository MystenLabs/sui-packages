module 0xb16fa31512eef7d756e194c10f34f42d141634583a56229d10f38cf2cbe6e647::supump {
    struct SUPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPUMP>(arg0, 9, b"Supump", b"Supump", b"New Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tradesanta.com/blog/wp-content/uploads/2022/03/pump-dump-1200x675.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPUMP>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

