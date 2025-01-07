module 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::withdraw_request {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct WITHDRAW_REQ has drop {
        dummy_field: bool,
    }

    struct WithdrawRequest<phantom T0> {
        sender: address,
        inner: 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::RequestBody<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>>,
    }

    public fun add_receipt<T0, T1>(arg0: &mut WithdrawRequest<T0>, arg1: &T1) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::add_receipt<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>, T1>(&mut arg0.inner, arg1);
    }

    public fun confirm<T0>(arg0: WithdrawRequest<T0>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>>) {
        let WithdrawRequest {
            sender : _,
            inner  : v1,
        } = arg0;
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::confirm<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>>(v1, arg1);
    }

    public fun new<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : WithdrawRequest<T0> {
        WithdrawRequest<T0>{
            sender : arg0,
            inner  : 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::new<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>>(arg1),
        }
    }

    public fun init_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>>, 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        let v0 = WITHDRAW_REQ{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::new_policy_with_type<T0, WITHDRAW_REQ>(v0, arg0, arg1)
    }

    public fun inner_mut<T0>(arg0: &mut WithdrawRequest<T0>) : &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::RequestBody<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, WITHDRAW_REQ>> {
        &mut arg0.inner
    }

    public fun tx_sender<T0>(arg0: &WithdrawRequest<T0>) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

