module 0xd8d54125fd7659c207056f3fd9a426c2230166041a9467c2224e62d16190c56f::sou {
    struct SOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOU>(arg0, 6, b"SOU", b"SUI ON UTYA", b"$SUI $UTYA isn't just another memecoin. It's a movement driven by community, spreading joy and positivity through the iconic Duck Emoji. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suita_e79a9c6c42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

