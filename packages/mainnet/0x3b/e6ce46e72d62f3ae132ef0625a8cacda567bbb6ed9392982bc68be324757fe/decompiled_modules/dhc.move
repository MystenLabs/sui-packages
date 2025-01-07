module 0x3be6ce46e72d62f3ae132ef0625a8cacda567bbb6ed9392982bc68be324757fe::dhc {
    struct DHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHC>(arg0, 9, b"DHC", b"Diamond Head Coin", b"The Official Currency For 93crypto.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/diamondrolls/homepage/master/images/Screenshot_20220823-191511_Chrome.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DHC>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

