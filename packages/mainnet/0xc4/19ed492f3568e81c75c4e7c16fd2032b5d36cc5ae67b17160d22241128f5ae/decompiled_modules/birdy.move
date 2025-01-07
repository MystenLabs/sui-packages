module 0xc419ed492f3568e81c75c4e7c16fd2032b5d36cc5ae67b17160d22241128f5ae::birdy {
    struct BIRDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDY>(arg0, 9, b"BIRDY", b"Feather", x"466561746865722069732061206c696768742c20666173742c20616e642065636f2d667269656e646c79206469676974616c2061737365742064657369676e656420666f7220736d6f6f74682c2074696e79207472616e73616374696f6e732e204974e2809973207065726665637420666f7220726577617264732c207374616b696e672c206f7220766f74696e672077697468696e20646563656e7472616c697a656420617070732c20616c6c207768696c65206b656570696e67207468696e6773207375737461696e61626c6520616e642066756e2e2053696d706c652c20656666696369656e742c20616e6420666561746865722d6c6967687421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1074622954405838849/ttxRMgsP.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIRDY>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

