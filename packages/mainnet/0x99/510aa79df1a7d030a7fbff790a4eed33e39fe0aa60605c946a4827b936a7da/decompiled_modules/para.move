module 0x99510aa79df1a7d030a7fbff790a4eed33e39fe0aa60605c946a4827b936a7da::para {
    struct PARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARA>(arg0, 9, b"para", b"para", b"paraa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

