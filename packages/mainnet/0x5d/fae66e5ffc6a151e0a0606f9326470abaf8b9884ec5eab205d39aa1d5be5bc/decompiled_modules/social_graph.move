module 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::social_graph {
    struct FollowRecord has key {
        id: 0x2::object::UID,
        follower: address,
        following: address,
    }

    struct Followed has copy, drop {
        follower: address,
        following: address,
    }

    struct Unfollowed has copy, drop {
        follower: address,
        following: address,
    }

    public fun follow(arg0: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg1: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg1);
        assert!(v0 != v1, 1);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg0) == v0, 3);
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::increment_following_count(arg0);
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::increment_follower_count(arg1);
        let v2 = Followed{
            follower  : v0,
            following : v1,
        };
        0x2::event::emit<Followed>(v2);
        let v3 = FollowRecord{
            id        : 0x2::object::new(arg2),
            follower  : v0,
            following : v1,
        };
        0x2::transfer::transfer<FollowRecord>(v3, v0);
    }

    public fun record_follower(arg0: &FollowRecord) : address {
        arg0.follower
    }

    public fun record_following(arg0: &FollowRecord) : address {
        arg0.following
    }

    public fun unfollow(arg0: FollowRecord, arg1: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg2: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.follower == v0, 2);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg1) == v0, 3);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg2) == arg0.following, 2);
        let FollowRecord {
            id        : v1,
            follower  : v2,
            following : v3,
        } = arg0;
        0x2::object::delete(v1);
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::decrement_following_count(arg1);
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::decrement_follower_count(arg2);
        let v4 = Unfollowed{
            follower  : v2,
            following : v3,
        };
        0x2::event::emit<Unfollowed>(v4);
    }

    // decompiled from Move bytecode v6
}

