module 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::entries {
    public entry fun pay(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::PaymentPool, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::UserArchieve, arg5: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::pay(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::UserReg, arg1: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::UserArchieve>(0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::PaymentPool, arg3: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion) {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund(arg0: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::PaymentTreasureCap, arg1: &mut 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::PaymentPool, arg2: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment::withdrawFund(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

