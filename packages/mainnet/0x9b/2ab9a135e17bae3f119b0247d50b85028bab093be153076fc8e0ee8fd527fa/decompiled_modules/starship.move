module 0x9b2ab9a135e17bae3f119b0247d50b85028bab093be153076fc8e0ee8fd527fa::starship {
    struct STARSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP>(arg0, 6, b"Starship", b"Elonmusk Starship", x"535441525348495020464c54350a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EL_On1_4174e4274f_bacf68c4e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

