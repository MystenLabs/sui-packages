module 0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::controller {
    public entry fun modify_controller(arg0: &mut 0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::is_emergency(arg0), 202);
        assert!(0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::is_emergency(arg0), 203);
        assert!(0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x7218d23111b10ad28d7881ff73cfafe8ce7081fc5726bb35b04a284379f0dca1::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

