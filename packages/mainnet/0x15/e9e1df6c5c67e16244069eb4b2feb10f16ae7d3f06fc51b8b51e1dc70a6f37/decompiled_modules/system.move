module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::system {
    struct PointCapIssued has copy, drop {
        project_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
    }

    struct ProjectCapIssued has copy, drop {
        project_id: 0x2::object::ID,
        recipient: address,
    }

    public fun create_project(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::system_domain());
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::new_project_cap(arg3);
        let v1 = ProjectCapIssued{
            project_id : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(&v0),
            recipient  : arg2,
        };
        0x2::event::emit<ProjectCapIssued>(v1);
        0x2::transfer::public_transfer<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(v0, arg2);
    }

    public fun issue_point_cap(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x2::tx_context::TxContext) : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_cap::PointCap {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::system_domain());
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_cap::new_point_cap(arg1, arg2);
        let v1 = PointCapIssued{
            project_id   : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(arg1),
            point_cap_id : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_cap::PointCap>(&v0),
        };
        0x2::event::emit<PointCapIssued>(v1);
        v0
    }

    public fun new_incentive_system(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::system_domain());
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::new_project_cap(arg3);
        0x2::transfer::public_transfer<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(v0, arg2);
        0x2::transfer::public_transfer<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_cap::PointCap>(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_cap::new_point_cap(&v0, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

