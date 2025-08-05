module 0x8728ed8ed70f0d565db67ee9ce906c73443b58101b32ce7703108f28899ff6b1::suiza {
    struct SUIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZA>(arg0, 6, b"SUIZA", b"Switzerland", x"245355495a412069732061206d656d6520636f696e20637265617465642062792033205370616e69617264732077686f2074726176656c656420746f20537769747a65726c616e6420666f7220776f726b2e0a496e737069726564206279207468652067726561746e657373206f6620537769747a65726c616e642c20697427732038382520636f6d6d756e6974792d6f776e65642e204c6f636b65642026207374616b65642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiazdlbnmy4ovcd3wq45ugnvd42hrhterqnzfljksuhpwdcgpldp7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

