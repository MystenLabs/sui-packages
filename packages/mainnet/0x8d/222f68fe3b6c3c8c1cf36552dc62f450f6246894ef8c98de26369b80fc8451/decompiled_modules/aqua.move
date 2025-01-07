module 0x8d222f68fe3b6c3c8c1cf36552dc62f450f6246894ef8c98de26369b80fc8451::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 9, b"AQUA", b"Aqua", x"41717561206f6e2053756920706f7765727320746865204171756120706c6174666f726d2c206120646563656e7472616c697a6564206c697175696469747920616e6420446546692065636f73797374656d2e20497420656e61626c6573207472616e73616374696f6e732c207374616b696e672c20676f7665726e616e63652c20616e6420726577617264732c206c657665726167696e6720537569e2809973206661737420616e64207363616c61626c6520626c6f636b636861696e20666f7220656666696369656e742074726164696e6720616e64206c6f772d636f7374207472616e73616374696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1554945530211340289/uSMGNdez.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AQUA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

