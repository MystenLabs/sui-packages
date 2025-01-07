module 0x3ee580397e0ef17afdc881258c94e044061001ec39be6bc2c568182a59eea955::moow {
    struct MOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOW>(arg0, 6, b"MOOW", b"$MooWrap", b"Get ready for the ultimate $MOOW takeover! The calf of memecoins is going LIVE on MovePump, exclusively on the blazing Sui Network! With the ticker MOOW, this token is set to stampede through the crypto space. Get your SUI bags ready? Dont miss your chance to load up on $MOOW and ride the wave to memecoin glory. Lets MOOW to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3552_ad666e3d71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

