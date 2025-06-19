module 0x80c204e59e0f55c7624210f04820c292a35176834756388397b47305cf2e7e1f::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"Slaunch", x"24532069732074686520616363657373206b657920746f20536c61756e63682e204974e2809973207573656420746f206561726e20706f696e74732c20756e6c6f636b2049414f732c2070617920666565732c2072616973652066756e64732c20616e6420766f74652e20506f696e747320636f6d652066726f6d20686f6c64696e672c207374616b696e672c206f722074726164696e672e205075626c696320726f756e64732072657175697265206275726e696e6720706f696e74732e204d696e64736861726520726577617264732061726520706169642073657061726174656c7920696e20245355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/e7e9c703-f1b2-436e-b79f-6d542536f167.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

