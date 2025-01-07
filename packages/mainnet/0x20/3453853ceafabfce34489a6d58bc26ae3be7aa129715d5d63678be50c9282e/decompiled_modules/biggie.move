module 0x203453853ceafabfce34489a6d58bc26ae3be7aa129715d5d63678be50c9282e::biggie {
    struct BIGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGGIE>(arg0, 9, b"BIGGIE", b"BigSui", b"BigSui is a bold, community-driven token on the SUI blockchain, offering fast, secure, and scalable transactions. Focused on bringing real utility to users, BigSui plays a key role in the growing SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1584362995089645568/ABtk90Em.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGGIE>(&mut v2, 333333333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGGIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

