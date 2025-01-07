module 0xcee672985890518ca7213542187b923b87182bfdb072a36d794eb056fab459a9::sempai {
    struct SEMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEMPAI>(arg0, 9, b"SEMPAI", b"Sempai", b"he is a good boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.fbhi5-1.fna.fbcdn.net/v/t39.30808-1/313364298_107298908850176_1603480705435923664_n.jpg?stp=dst-jpg_p320x320&_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=hfsLl5Z22ZoAX8LBNOe&_nc_ht=scontent.fbhi5-1.fna&oh=00_AfDth6m_U0KPFicfN-EuN1nf_zs6JZBoiVItuCbCaPAhmQ&oe=66129CEC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEMPAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEMPAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEMPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

