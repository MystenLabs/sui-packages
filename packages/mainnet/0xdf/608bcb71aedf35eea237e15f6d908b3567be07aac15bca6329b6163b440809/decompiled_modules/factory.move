module 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::factory {
    struct SATS has drop {
        dummy_field: bool,
    }

    struct ORDI has drop {
        dummy_field: bool,
    }

    struct RATS has drop {
        dummy_field: bool,
    }

    struct QUARK has drop {
        dummy_field: bool,
    }

    struct ATOM has drop {
        dummy_field: bool,
    }

    struct UP has drop {
        dummy_field: bool,
    }

    struct UBTC has drop {
        dummy_field: bool,
    }

    struct TTTT has drop {
        dummy_field: bool,
    }

    struct AORD has drop {
        dummy_field: bool,
    }

    struct ASAT has drop {
        dummy_field: bool,
    }

    struct AQUARK has drop {
        dummy_field: bool,
    }

    struct AATOM has drop {
        dummy_field: bool,
    }

    struct AUP has drop {
        dummy_field: bool,
    }

    struct ETHS has drop {
        dummy_field: bool,
    }

    struct ETHI has drop {
        dummy_field: bool,
    }

    struct ETHR has drop {
        dummy_field: bool,
    }

    struct BNBS has drop {
        dummy_field: bool,
    }

    struct BSCI has drop {
        dummy_field: bool,
    }

    struct BSCR has drop {
        dummy_field: bool,
    }

    public entry fun create<T0: drop>(arg0: T0, arg1: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::createUNIPORT20<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun createAATOM(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AATOM{dummy_field: false};
        create<AATOM>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createAORD(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AORD{dummy_field: false};
        create<AORD>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createAQUARK(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AQUARK{dummy_field: false};
        create<AQUARK>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createASAT(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ASAT{dummy_field: false};
        create<ASAT>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createATOM(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ATOM{dummy_field: false};
        create<ATOM>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createAUP(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AUP{dummy_field: false};
        create<AUP>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBNBS(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BNBS{dummy_field: false};
        create<BNBS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBSCI(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BSCI{dummy_field: false};
        create<BSCI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBSCR(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BSCR{dummy_field: false};
        create<BSCR>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHI(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHI{dummy_field: false};
        create<ETHI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHR(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHR{dummy_field: false};
        create<ETHR>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHS(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHS{dummy_field: false};
        create<ETHS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createORDI(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ORDI{dummy_field: false};
        create<ORDI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createQUARK(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = QUARK{dummy_field: false};
        create<QUARK>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createRATS(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RATS{dummy_field: false};
        create<RATS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createSATS(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SATS{dummy_field: false};
        create<SATS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createTTTT(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TTTT{dummy_field: false};
        create<TTTT>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createUBTC(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UBTC{dummy_field: false};
        create<UBTC>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createUP(arg0: &mut 0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0xdf608bcb71aedf35eea237e15f6d908b3567be07aac15bca6329b6163b440809::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UP{dummy_field: false};
        create<UP>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

