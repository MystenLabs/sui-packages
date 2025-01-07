module 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::factory {
    struct ORDI has drop {
        dummy_field: bool,
    }

    struct SATS has drop {
        dummy_field: bool,
    }

    struct RATS has drop {
        dummy_field: bool,
    }

    struct MEME has drop {
        dummy_field: bool,
    }

    struct PUNK has drop {
        dummy_field: bool,
    }

    struct PEPE has drop {
        dummy_field: bool,
    }

    struct BAYC has drop {
        dummy_field: bool,
    }

    struct ATOM has drop {
        dummy_field: bool,
    }

    struct QUARK has drop {
        dummy_field: bool,
    }

    struct ELECTRON has drop {
        dummy_field: bool,
    }

    struct REALM has drop {
        dummy_field: bool,
    }

    struct NEUTRON has drop {
        dummy_field: bool,
    }

    struct AVM has drop {
        dummy_field: bool,
    }

    struct PROTON has drop {
        dummy_field: bool,
    }

    struct SOPHON has drop {
        dummy_field: bool,
    }

    struct UP has drop {
        dummy_field: bool,
    }

    struct UBTC has drop {
        dummy_field: bool,
    }

    struct BTC has drop {
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

    public entry fun create<T0: drop>(arg0: T0, arg1: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::createUNIPORT20<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun createATOM(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ATOM{dummy_field: false};
        create<ATOM>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createAVM(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AVM{dummy_field: false};
        create<AVM>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBAYC(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BAYC{dummy_field: false};
        create<BAYC>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBNBS(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BNBS{dummy_field: false};
        create<BNBS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBSCI(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BSCI{dummy_field: false};
        create<BSCI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBSCR(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BSCR{dummy_field: false};
        create<BSCR>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createBTC(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = BTC{dummy_field: false};
        create<BTC>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createELECTRON(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ELECTRON{dummy_field: false};
        create<ELECTRON>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHI(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHI{dummy_field: false};
        create<ETHI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHR(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHR{dummy_field: false};
        create<ETHR>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createETHS(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ETHS{dummy_field: false};
        create<ETHS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createMEME(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MEME{dummy_field: false};
        create<MEME>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createNEUTRON(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NEUTRON{dummy_field: false};
        create<NEUTRON>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createORDI(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ORDI{dummy_field: false};
        create<ORDI>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createPEPE(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PEPE{dummy_field: false};
        create<PEPE>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createPROTON(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PROTON{dummy_field: false};
        create<PROTON>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createPUNK(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PUNK{dummy_field: false};
        create<PUNK>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createQUARK(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = QUARK{dummy_field: false};
        create<QUARK>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createRATS(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RATS{dummy_field: false};
        create<RATS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createREALM(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = REALM{dummy_field: false};
        create<REALM>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createSATS(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SATS{dummy_field: false};
        create<SATS>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createSOPHON(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SOPHON{dummy_field: false};
        create<SOPHON>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createUBTC(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UBTC{dummy_field: false};
        create<UBTC>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createUP(arg0: &mut 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeState, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge::BridgeAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UP{dummy_field: false};
        create<UP>(v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

