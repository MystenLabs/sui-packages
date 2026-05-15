module 0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain_seal {
    public fun seal_approve(arg0: vector<u8>, arg1: &0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::FormOwnerCap, arg2: &0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::Form, arg3: &0x2::tx_context::TxContext) {
        assert!(0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::cap_owner(arg1) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::cap_form_id(arg1) == 0x2::object::id<0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::Form>(arg2), 1);
    }

    public fun seal_approve_any_owner(arg0: vector<u8>, arg1: &0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::FormOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x836ecca57484267ffa2b53743b34ab7c5c3ba4cd72128c61adb0ca0bfe5689c::formchain::cap_owner(arg1) == 0x2::tx_context::sender(arg2), 1);
    }

    // decompiled from Move bytecode v7
}

