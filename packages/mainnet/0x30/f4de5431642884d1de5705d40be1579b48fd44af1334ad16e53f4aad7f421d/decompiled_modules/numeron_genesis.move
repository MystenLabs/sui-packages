module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_genesis {
    public entry fun run(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_dapp_system::create(0x1::ascii::string(b"numeron"), 0x1::ascii::string(b"numeron contract"), arg0, arg1);
        let v1 = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::create(arg1);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_deploy_hook::run(&mut v1, arg1);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_dapp_schema::add_schema<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema>(&mut v0, v1);
        0x2::transfer::public_share_object<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_dapp_schema::Dapp>(v0);
    }

    // decompiled from Move bytecode v6
}

