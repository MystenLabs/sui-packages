module 0xb5ca4cb9885bb80cbc227e501978075b45db733fb95c4e1842788e90b823953b::doge_sui {
    struct DOGE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE_SUI>(arg0, 6, b"DOGE_Sui", b"Dep of G Efficiency", x"496e74726f647563696e6720746865204465706172746d656e74206f6620476f7665726e6d656e7420456666696369656e637920285375692920636f696e3a20626563617573652077686f20736179732062757265617563726163792063616ee28099742062652066756e3f0a0a496e206120776f726c642077686572652077616974696e6720696e206c696e65206665656c73206c696b6520616e2065787472656d652073706f72742c20616e642066696c696e67207061706572776f726b207365656d73206c696b65206120717565737420696e20616e205250472c2077652070726f75646c792070726573656e74207468652053756920436f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731280543805.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

