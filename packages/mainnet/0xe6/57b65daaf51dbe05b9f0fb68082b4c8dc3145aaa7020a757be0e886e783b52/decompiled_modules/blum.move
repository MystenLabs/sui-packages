module 0xe657b65daaf51dbe05b9f0fb68082b4c8dc3145aaa7020a757be0e886e783b52::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 8, b"Blum", b"Blum", x"596f757220656173792c2066756e2063727970746f2074726164696e672061707020666f7220627579696e6720616e642074726164696e6720616e7920636f696e206f6e20746865206d61726b65742e2053797374656d206865616c746820262064657620757064617465733a200a40426c756d5f5374617475730a2e20537570706f72743a20687474703a2f2f742e6d652f426c756d537570706f7274", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0c406460-1c36-4db2-9d71-92ca862b7346.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

