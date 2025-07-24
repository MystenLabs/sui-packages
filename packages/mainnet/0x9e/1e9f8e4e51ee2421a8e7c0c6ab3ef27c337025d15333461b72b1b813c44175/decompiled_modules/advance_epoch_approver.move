module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver {
    struct AdvanceEpochApprover {
        new_epoch: u64,
        remaining_witnesses_to_approve: vector<0x1::string::String>,
        balance_ika: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
    }

    public fun approve_advance_epoch_by_witness<T0: drop>(arg0: &mut AdvanceEpochApprover, arg1: T0, arg2: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()));
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg0.remaining_witnesses_to_approve, &v0);
        assert!(v1, 0);
        0x1::vector::remove<0x1::string::String>(&mut arg0.remaining_witnesses_to_approve, v2);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.balance_ika, arg2);
    }

    public fun assert_all_witnesses_approved(arg0: &AdvanceEpochApprover) {
        assert!(0x1::vector::is_empty<0x1::string::String>(&arg0.remaining_witnesses_to_approve), 0);
    }

    public fun create(arg0: u64, arg1: vector<0x1::string::String>, arg2: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : AdvanceEpochApprover {
        AdvanceEpochApprover{
            new_epoch                      : arg0,
            remaining_witnesses_to_approve : arg1,
            balance_ika                    : arg2,
        }
    }

    public fun destroy(arg0: AdvanceEpochApprover, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        let AdvanceEpochApprover {
            new_epoch                      : _,
            remaining_witnesses_to_approve : _,
            balance_ika                    : v2,
        } = arg0;
        v2
    }

    public fun new_epoch(arg0: &AdvanceEpochApprover) : u64 {
        arg0.new_epoch
    }

    // decompiled from Move bytecode v6
}

