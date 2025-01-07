module 0x8eefdc45700fb32ec586631ff4bfd1d1abc766758798e90ea4b39f57535557c3::faith {
    struct FAITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAITH>(arg0, 6, b"FAITH", b"have some", b"Introducing \"Faith\" Coin  the only memecoin where believing is seeing! Its the divine intervention of the crypto world, rumored to turn water into wine and fiat into fortunes. Invest your faith and watch miracles happen one block at a time. Dont miss out, or you'll be left praying for a second coming! Join the believers and let your portfolio ascend to heavenly heights. #KeepTheFaith ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kuk81p_MZ_400x400_c3954fd22f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAITH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAITH>>(v1);
    }

    // decompiled from Move bytecode v6
}

