module 0x1aae2866d3d3beee8fffc11ed346e25421851a7a81bc416e8af711840527f9fd::web1930 {
    struct WEB1930 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEB1930, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEB1930>(arg0, 6, b"WEB1930", b"Warren Buffet", b"The first rule of an investment is don't lose (money). And the second rule of an investment is don't forget the first rule. That's why WEB1930 is here, to make you money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000084397_69a741a8eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEB1930>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEB1930>>(v1);
    }

    // decompiled from Move bytecode v6
}

